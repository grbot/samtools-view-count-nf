#!/usr/bin/env nextflow

params.input = null

input = params.input

def helpMessage(message) {
    log.info"""
    ${message}

    Count the number of reads of a SAM/BAM/CRAM file using samtools view and print to stdout

    Usage:

    nextflow run jb-adams/samtools-view-count-nf --input \${INPUT}

    Mandatory arguments:
      --input    [string] local path or URL to input SAM/BAM/CRAM
    
    Optional arguments:
      --help     [flag] display this help message and exit
    
    """.stripIndent()
}

if (params.help) exit 0, helpMessage("")

if (input == null) {
    exit 1, helpMessage("ERROR: no --input specified")
}

process samtools_view {

    output:
    stdout samtools_view

    script:
    """
    echo "Running samtools view on ${input}" >&2
    samtools view -c ${input}
    """
}

samtools_view.view {it.trim()}
