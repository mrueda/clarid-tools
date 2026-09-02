# ClarID Specification

The tables below define the exact source fields, constraints, and encoding rules
for the human-readable and stub formats of both `biosample` and `subject`
identifiers.

## Biosample

### Human format  
**Delimiter:** `-`

| #  | Component   | Source field                | Type         | Pattern / Format                                           | Built from                                 |
|---:|-------------|-----------------------------|--------------|------------------------------------------------------------|---------------------------------------------|
| 1  | Project     | `project.code`              | string       | free string                                                | codebook value (if present)                    |
| 2  | Species     | `species.code`              | string       | 6-letter binomial acronym (e.g. `HomSap`)                   | codebook value                              |
| 3  | Subject ID  | `subject_id`                | integer→str  | zero-pad to 5 digits (default)                              | `sprintf("%0${pad}d",$sid)`                |
| 4  | Tissue      | `tissue.code`               | string       | exactly 3 letters `[A-Z]{3}`                                | codebook value                              |
| 5  | Sample Type | `sample_type.code`          | string       | exactly 3 letters `[A-Z]{3}`                                | codebook value                              |
| 6  | Assay       | `assay.code`                | string       | exactly 3 letters `[A-Z]{3}`                                | codebook value                              |
| 7  | Condition   | `condition`                 | string       | ICD-10 diagnosis code(s) `[A-Z]\d{2}(?:\.\d+)?` (≤10),      | used verbatim (or concatenated with `+`)    |
| 8  | Timepoint   | `timepoint`                 | string       | alphanumeric events e.g. `Baseline`                   | codebook value                  |
| 9  | Duration    | `duration`                  | string       | ISO 8601 3-char (`P1D`,`P7W`,`P3M`,`P1Y`) or `P0N` (Not Available)                  | `duration_pattern`                         |
| 10 | Batch (opt) | `batch`                     | integer→str  | `B%02d` (e.g. `B01`)                                        | `batch_pattern`                            |
| 11 | Replicate (opt) | `replicate`             | integer→str  | `R%02d` (e.g. `R05`)                                        | `replicate_pattern`                        |

> Note (`duration`): The 3-character limit (`PnU`) is intentional, designed to keep duration compact and consistent rather than represent every possible duration in full detail; see [duration binning](./pre-processing-script.md#duration-binning-days-to-iso8601-pnu). This constraint may evolve with community feedback.

### Stub format  
**Delimiter:** _(none)_

:::note[About Base62 in stub fields]
Base62 is used here as a compact encoding alphabet, not as a semantic abbreviation. Stub fields are optimized for compactness and stable parsing, so they are not expected to look visually similar to the human-readable format.

:::
| #  | Component      | Source field                | Type            | Pattern / Format                       | Built from                                |
|---:|----------------|-----------------------------|-----------------|-----------------------------------------|--------------------------------------------|
| 1  | Project stub   | `project.stub_code`         | string          | free string                            | codebook value                             |
| 2  | Species stub   | `species.stub_code`         | string          | codebook-defined stub width (Base62 alphabet recommended) | codebook value                  |
| 3  | Subject stub   | `subject_id`                | integer→Base62 | width 3 (default) — max 238,327        | 3-char Base62 from integer             |
| 4  | Tissue stub    | `tissue.stub_code`          | string          | 1–3 chars                              | codebook value                             |
| 5  | Sample Type stub | `sample_type.stub_code`   | string          | 1–3 chars                              | codebook value                             |
| 6  | Assay stub     | `assay.stub_code`           | string          | 1–3 chars                              | codebook value                             |
| 7  | Condition stub | `condition`                 | code→Base62    | N × 3-char Base62 stubs + 2-digit count (`%02d`)           | packaged ICD-10 order map + 3-char Base62 from integer |
| 8  | Timepoint stub | `timepoint.stub_code`       | string          | 1–2 chars                              | codebook value                   |
| 9  | Duration stub  | `duration`                  | string          | single digit + unit (e.g. `7W`)         | `duration_pattern`                         |
| 10 | Batch stub (opt) | `batch`                  | integer         |  `B%02d` (e.g. `B01`)                     | `batch_pattern`                            |
| 11 | Replicate stub (opt) | `replicate`         | integer         | `R%02d` (e.g. `R05`)                       | `replicate_pattern`                        |

> Note (`species` + `subject_id`): in stub format these fields are encoded independently. `species` uses a static codebook `stub_code`, whereas `subject_id` is converted from the numeric subject identifier into fixed-width Base62. They are therefore compact counterparts of the same metadata, but not character-by-character transformations of the human-readable fields.

> Note (`species` width): species stub width is defined by the codebook and should be consistent within a given codebook. The reference codebook uses width 2.

> Note (`condition` mapping): the numeric mapping used for stub `condition`
> values depends on the packaged ICD-10 order map. Decode condition stubs with
> the same ClarID-Tools release and mapping resources used for encoding.

---

## Subject

### Human format  
**Delimiter:** `-`

| # | Component   | Source field           | Type         | Pattern / Format                      | Built from                               |
|--:|-------------|------------------------|--------------|----------------------------------------|-------------------------------------------|
| 1 | Study       | `study`                | string       | free string                           | codebook value (if present)                  |
| 2 | Subject ID  | `subject_id`           | integer→str  | zero-pad to 5 digits (default)         | `sprintf("%0${pad}d",$sid)`             |
| 3 | Type        | `type.code`            | string       | codebook codes                        | codebook value                            |
| 4 | Condition   | `condition`            | string       | ICD-10 diagnosis code(s) `[A-Z]\d{2}(?:\.\d+)?` (≤10),      | used verbatim (or concatenated with `+`)    |
| 5 | Sex         | `sex.code`             | string       | codebook codes                        | codebook value                            |
| 6 | Age Group   | `age_group.code`       | string       | codebook codes                        | codebook value                            |

### Stub format  
**Delimiter:** _(none)_

| # | Component        | Source field               | Type            | Pattern / Format            | Built from                               |
|--:|------------------|----------------------------|-----------------|-----------------------------|-------------------------------------------|
| 1 | Study stub       | `study.stub_code`          | string          | free string                 | codebook value (if present)               |
| 2 | Subject ID stub  | `subject_id`               | integer→Base62 | width 3 (default) — max 238,327        | 3-char Base62 from integer             |
| 3 | Type stub        | `type.stub_code`           | string          | 1 char                      | codebook value                            |
| 4 | Condition stub   | `condition`                | code→Base62    | N × 3-char Base62 stubs + 2-digit count (`%02d`)     | packaged ICD-10 order map + 3-char Base62 from integer |
| 5 | Sex stub         | `sex.stub_code`            | string          | 1 char                      | codebook value                            |
| 6 | Age Group stub   | `age_group.stub_code`      | string          | 2 chars                     | codebook value                            |

> Note (`condition` mapping): as in biosample stub format, the numeric mapping for `condition` depends on the packaged ICD-10 order map distributed with the reference implementation. Encoded values should therefore be interpreted together with the corresponding ClarID-Tools release and associated resources.
