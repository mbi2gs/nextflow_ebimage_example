#! /usr/bin/env nextflow

params.in_files = 'data/Dros_*'

in_images = Channel.fromPath( params.in_files )

process count_nuclei {
    container 'mbiggs/r_ebimage'

    input:
    file i from in_images

    output:
    file '*.csv' into csv_out

    script:
    """
    Rscript $baseDir/bin/ia.R $i > out.csv
    """

}

iprocess plot_nucleus_counts {
    container 'rocker/tidyverse'

    input:
    file i from csv_out.collectFile(name: 'counts.csv', newLine: true)

    output:
    file 'plot.png' into out_plot

    script:
    """
    #!/usr/bin/env Rscript
    
    library(tidyverse)
    cat(1)
    """

}
