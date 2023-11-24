register(DataDep(
  "acute-inflammations-2",
  "http://archive.ics.uci.edu/ml/datasets/Acute+Inflammations",
  "http://archive.ics.uci.edu/ml/machine-learning-databases/acute/diagnosis.data",
  "5d0b61049992b8327aa847f916f3389ec08f74b43dbb3fc5222ac07185d7c88f",
  post_fetch_method=(path -> begin
    # File is UTF-16 and first 2 bytes are BOM
    utf16 = reinterpret(UInt16, read(path))
    if utf16[1] == 0xfffe # BOM indicates non-native endianness
      utf16 .= bswap.(utf16)
    end
    @views data = transcode(String, utf16[2:end])
    data = replace(data, "," => ".")
    write(path, data)

    UCIData.process_dataset(path,
        target_index=8,
        feature_indices=1:6,
        categoric_indices=2:6,
        delim='\t',
    )
  end),
))
