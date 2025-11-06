# import basic packages
import pandas as pd
from snakemake.utils import validate


# read sample sheet
samples = (
    pd.read_csv(config["samplesheet"], sep="\t", dtype={"sample_name": str})
    .set_index("sample_name", drop=False)
    .sort_index()
)


# validate sample sheet and config file
validate(samples, schema="../../config/schemas/samples.schema.yaml")
validate(config, schema="../../config/schemas/config.schema.yaml")


def get_fastqs(wildcards):
    u = samples.loc[wildcards.sample]
    return {"fastqs": u["fastqs"]}
