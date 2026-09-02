# Frequently Asked Questions

## Codebook

<details>
<summary>Why do the `species` and `subject_id` parts of stub IDs not look like the human-readable version?</summary>


Because they are encoded independently for compactness.

* `species` uses a static 2-character `stub_code` from the YAML codebook
* `subject_id` is converted from the numeric subject identifier into fixed-width Base62

Stub fields therefore represent the same metadata as the human-readable form, but they are not character-by-character abbreviations of it.

</details>
<details>
<summary>For `condition` do I need to encode to ICD-10 before ClarID-Tools?</summary>


Yes, ClarID-Tools reads ICD-10 diagnosis codes. Take a look at the [pre-processing documentation](/technical-details/pre-processing-script).

</details>
<details>
<summary>Can I include multiple ICD-10 diagnosis codes?</summary>


Yes. 

* Command-line: `--condition C22.1,C22.2` (comma separated)
* Bulk (CSV): Separate them by `;` (semicolon) 

The maximum is set with the parameter `--max_conditions`, which defaults to **10**. We reserve 2 chars for that field, so the limit is 99 conditions.

</details>
<details>
<summary>Does the stub `condition` encoding depend on the YAML order?</summary>


No. In the current reference implementation, stub `condition` values are derived from the packaged ICD-10 order map distributed with ClarID-Tools.

Decode condition stubs with the same ClarID-Tools release and mapping resources
used for encoding.

</details>
<details>
<summary>What is the difference between `--subject_id_pad_length` and `--subject_id_base62_width`?</summary>


They control different formats of the same `subject_id` field.

* `--subject_id_pad_length` controls decimal zero-padding in human-readable IDs
* `--subject_id_base62_width` controls the width of the Base62 field in stub IDs

Example:

* human format: `subject_id = 42` with pad length 5 becomes `00042`
* stub format: `subject_id = 42` with Base62 width 3 becomes a 3-character Base62 stub

</details>
<details>
<summary>Which ICD-10 code should I use when no specific disease is available?</summary>


Since we rely on ICD-10 coding, we have selected code Z00.00 ("Encounter for general adult medical examination without abnormal findings").

If you believe there is a more appropriate code for this context, please feel free to suggest it.

</details>
## Usage and Troubleshooting

<details>
<summary>When should I use `human` format versus `stub` format?</summary>


Use `human` format when the identifier will be inspected directly by people.

Use `stub` format when you need a compact identifier for labels, QR codes, filenames, or systems with tighter space constraints.

</details>
<details>
<summary>Why do I see duplicated columns after decoding a CSV file?</summary>


In bulk decode mode, ClarID-Tools appends decoded fields to the right of the existing input table. If the source table already contains some of those columns, they will appear duplicated in the output.

</details>
<details>
<summary>What are the most common reasons encoding fails?</summary>


The most common causes are:

* a metadata value is missing from the YAML codebook
* the wrong input separator was used
* the `condition` value is malformed or not normalized as expected
* a required field for the selected entity or format is missing

</details>
<details>
<summary>What are the most common reasons decoding fails?</summary>


The most common causes are:

* `--clar_id` or `--stub_id` was not provided in single-record mode
* the wrong format was selected for the identifier being decoded
* a bulk input file does not contain the expected ID column
* the codebook used for decoding does not match the one used for encoding

</details>
## General

<details>
<summary>What does ClarID mean?</summary>


ClarID is named to evoke the idea of a **clear ID**: an identifier whose structure makes selected metadata easier to interpret.

The name also reflects the Catalan word *clar*, meaning "clear". In the biomedical context, **ClarID** can also be read as **CL**inical **A**nd **R**esearch **ID**, pointing to its intended use across clinical and research metadata workflows.

</details>
<details>
<summary>How do I cite `clarid-tools`?</summary>


You can cite the **ClarID-Tools** paper.

:::note[Citation]
Rueda, M. and Gut, I.G. (2026). ClarID: a human-readable and compact identifier specification for biomedical metadata integration. _Journal of Biomedical Semantics_ 17, 9. https://doi.org/10.1186/s13326-026-00349-6

:::
</details>
