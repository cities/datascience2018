#' Reads data in 'file_name' as a data frame
#'
#' Read data file 'file_name' as a data frame with external packages
#' @param file_name name of the file that contains bike counts
#' @return a data frame with bike counts
#' @export
read_data <- function(file_name) {
  print(paste(file_name, "is ready to be read into R"))
  my_df <- readxl::read_excel(file_name)
  return(my_df)
}
