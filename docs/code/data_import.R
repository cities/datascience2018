


fwf_pos <- fwf_empty("data/NCDC-CDO-USC00356750.txt")
test_df <- read_fwf("data/NCDC-CDO-USC00356750.txt", col_positions = fwf_pos)

test_df <- read_fwf("data/NCDC-CDO-USC00356750.txt", 
                    col_positions = fwf_positions(c(1, 20, 112),
                                                  end=c(19, 69, 120),
                                                  col_names = c("STATION", "NAME", "PRCP")),
                    skip=2)


