# This script will be used to populate the \data directory
# with all necessary raw data files.

# Create raw data folder
# dir.create("data/raw", showWarnings = FALSE, recursive = TRUE)

# Download data files
urls <- c("https://datasets.imdbws.com/title.basics.tsv.gz",
          "https://datasets.imdbws.com/title.ratings.tsv.gz")

for (url in urls) {
  filename <- basename(url)
  download.file(url, file.path("../../data/raw", filename))
}

