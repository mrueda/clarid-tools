# Use from R

Call `clarid-tools` from R with `system2()`: write the input table to CSV, run
the CLI, and read the output CSV. No R package or Perl-to-R bridge is required.

## Before you start

Check whether `clarid-tools` is available in your shell:

```r
Sys.which("clarid-tools")
```

If you are working from a repository checkout instead of an installed command,
use the repository executable:

```r
clarid_tools <- "bin/clarid-tools"
```

Otherwise:

```r
clarid_tools <- "clarid-tools"
```

## Minimal helper

Use `system2()` so each command-line option and value is passed as a separate
argument. It keeps the R code close to the CLI command while avoiding shell
quoting problems with paths and metadata values.

```r
run_clarid <- function(args, output, executable = "clarid-tools") {
  log <- system2(
    executable,
    args = args,
    stdout = TRUE,
    stderr = TRUE
  )

  status <- attr(log, "status")
  if (!is.null(status) && status != 0) {
    stop(paste(log, collapse = "\n"), call. = FALSE)
  }

  if (!file.exists(output)) {
    stop(paste(log, collapse = "\n"), call. = FALSE)
  }

  output
}
```

## Encode a table from R

Create a normal R data frame, write it to CSV, run `clarid-tools code`, and read
the encoded CSV back into R. The same approach works for larger tables generated
from Bioconductor objects, clinical metadata exports, or project spreadsheets.

```r
clarid_tools <- "clarid-tools"

workdir <- tempfile("clarid-")
dir.create(workdir)

input_file <- file.path(workdir, "biosample.csv")
output_file <- file.path(workdir, "biosample_encoded.csv")

biosamples <- data.frame(
  unique_id = c("samp001", "samp002"),
  subject_id = c(1, 2),
  project = c("TCGA-AML", "TCGA-AML"),
  species = c("Human", "Mouse"),
  tissue = c("Liver", "Brain"),
  sample_type = c("Normal", "Tumor"),
  assay = c("RNA_seq", "ChIP_seq"),
  condition = c("Z77.22", "Z77.22"),
  timepoint = c("Baseline", "Treatment"),
  duration = c("P1D", "P7W"),
  batch = c(1, 2),
  replicate = c(5, 2),
  check.names = FALSE
)

write.csv(biosamples, input_file, row.names = FALSE, quote = TRUE)

run_clarid(
  args = c(
    "code",
    "--entity", "biosample",
    "--format", "human",
    "--action", "encode",
    "--infile", input_file,
    "--sep", ",",
    "--outfile", output_file
  ),
  output = output_file,
  executable = clarid_tools
)

encoded <- read.csv(output_file, check.names = FALSE)
encoded$clar_id
```

## Decode IDs from R

Use the same pattern for decoding. The input table needs a `clar_id` column for
human-format identifiers or a `stub_id` column for stub-format identifiers.

```r
decode_input <- file.path(workdir, "biosample_to_decode.csv")
decode_output <- file.path(workdir, "biosample_decoded.csv")

write.csv(
  encoded[, c("unique_id", "clar_id")],
  decode_input,
  row.names = FALSE,
  quote = TRUE
)

run_clarid(
  args = c(
    "code",
    "--entity", "biosample",
    "--format", "human",
    "--action", "decode",
    "--infile", decode_input,
    "--sep", ",",
    "--outfile", decode_output
  ),
  output = decode_output,
  executable = clarid_tools
)

decoded <- read.csv(decode_output, check.names = FALSE)
decoded
```

## Notes

- Add `--codebook /path/to/clarid-codebook.yaml` when using a project-specific
  codebook. If omitted, ClarID-Tools uses the packaged default codebook.
- Keep generated files in a project or temporary directory so R, shell scripts,
  and workflow managers can all inspect the same inputs and outputs.
- For Docker-based runs, use the same `system2()` pattern but call `docker` as
  the executable and pass the ClarID-Tools command as container arguments.
