# Collect outputs into a file

## Problem

You need to publish the output files produced by an upstream process.

## Solution

Use [collectFile](https://www.nextflow.io/docs/latest/operator.html#collectfile)
to publish all files into a single directory.

## Code

```nextflow

Channel.fromPath('reads/*_1.fq.gz').set { samples_ch }

process foo {
  input:
  file x from samples_ch
  output:
  file '*.fq' into unzipped_ch
  script:
  """
  unzipped=\$(basename $x .gz)
  gzip -dc $x > \$unzipped
  """
}

unzipped_ch
      .collectFile(storeDir: 'unzipped_fqs')
```

## Run it

Use the the following command to execute the example:

    nextflow run main.nf
