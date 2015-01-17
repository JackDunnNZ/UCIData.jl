#!/usr/bin/python

from itertools import combinations


def main(datafile, outfile, class_index, id_indices, values_indices,
         categoric_indices, separator, normalise=True, header=False):

    f_in = open(datafile, 'rU')

    classes = {}
    class_count = 0

    categoric_classes = [{} for _ in values_indices]
    categoric_counts = [0 for _ in values_indices]
    categoric_set = frozenset(categoric_indices)

    max_val = [-1e10] * len(values_indices)
    min_val = [1e10] * len(values_indices)

    row_values = []
    row_classes = []
    row_ids = []

    lines = f_in.readlines()

    if header:
        lines = lines[1:]

    for i, line in enumerate(lines):
        if separator:
            lines[i] = line.strip('\n').split(separator)
        else:
            lines[i] = line.strip('\n').split()

        row_class = lines[i][class_index]
        if row_class not in classes:
          classes[row_class] = class_count
          class_count += 1
        row_classes.append(classes[row_class])

        if id_indices:
            row_ids.append('_'.join([lines[i][j] for j in id_indices]))
        else:
            row_ids.append(str(i))

        v = [lines[i][j] for j in values_indices]

        for j, val in enumerate(v):
            if values_indices[j] in categoric_set:
                if val not in categoric_classes[j]:
                    categoric_classes[j][val] = categoric_counts[j]
                    categoric_counts[j] += 1
                lines[i][values_indices[j]] = categoric_classes[j][val]
            else:
                val = float(val)
                if max_val[j] < val:
                    max_val[j] = val
                if min_val[j] > val:
                    min_val[j] = val

    for i, j in enumerate(values_indices):
        if j in categoric_set:
            max_val[i] = categoric_counts[j] - 1
            min_val[i] = 0

    # Normalise
    if normalise:
        for line in lines:
            values = [line[j] for j in values_indices]
            row_values.append([str((float(x) - z) / float(y - z))
                               for x, y, z in zip(values, max_val, min_val)])
    else:
        for line in lines:
            row_values.append([line[j] for j in values_indices])

    f = []
    for i, j in combinations(classes.itervalues(), 2):
        f.append(open('../../cleaned_data/' + outfile + '.' + str(i) + '.' + str(j), 'w'))

    for i, line in enumerate(lines):
        row_class = row_classes[i]
        row_id = row_ids[i]
        out_string = ','.join([row_id] + row_values[i]) + ','

        for i, comb in enumerate(combinations(classes.itervalues(), 2)):
            if row_class in comb:
                row_class_new = 0 if row_class == comb[0] else 1
                f[i].write(out_string + str(row_class_new) + '\n')

    f_in.close()
    for f_out in f:
        f_out.close()
