
# How to create directory, check if directory exist, made, saved and object loaded from directory

# Create directory
# add 'recursive = TRUE' to create any necessary parent directories
dir.create(paste("./data/home_range/", period, "/Fits_with_error", sep = ""), recursive = TRUE)
Model_path = paste("./data/home_range/", period, "/Fits_with_error", sep = "")


cat("Checking existence of directories:\n")
cat("Model_path exists:", dir.exists(Model_path), "\n")
cat("UD_path exists:", dir.exists(UD_path), "\n")
cat("Fig_Path exists:", dir.exists(Fig_Path), "\n")

test <- 1
ctmm_test_path <- file.path(Model_path, paste("Fits_", "test", ".rda", sep = ""))
akde_test_path <- file.path(UD_path, paste("UD_", "test", ".rda", sep = ""))
fig_test_path <- file.path(Fig_Path, paste("ctmm_", "test", ".png", sep = ""))

# Test saving in Model_path
tryCatch({
  save(test, file = ctmm_test_path)
  cat("Successfully saved test object in Model_path\n")
}, error = function(e) {
  cat("Failed to save test object in Model_path\n")
  message("Error details:", e$message, "\n")
})

# Load test object 
tryCatch({
  loaded_test <- load(ctmm_test_path)
  cat("Successfully loaded test object from Model_path\n")
  cat("Value of loaded_test:", loaded_test, "\n")
}, error = function(e) {
  cat("Failed to load test object from Model_path\n")
  message("Error details:", e$message, "\n")
})

if (file.exists(ctmm_test_path)) {
  loaded_test <- load(ctmm_test_path)
  cat("Successfully loaded test object from Model_path\n")
  cat("Value of loaded_test:", loaded_test, "\n")
} else {
  cat("File does not exist in Model_path\n")
}