#!/usr/bin/env nextflow

/*
 * Copyright (c) 2013-2016, Centre for Genomic Regulation (CRG).
 * Copyright (c) 2013-2016, Paolo Di Tommaso and the respective authors.
 *
 *   This file is part of 'Nextflow'.
 *
 *   Nextflow is free software: you can redistribute it and/or modify
 *   it under the terms of the GNU General Public License as published by
 *   the Free Software Foundation, either version 3 of the License, or
 *   (at your option) any later version.
 *
 *   Nextflow is distributed in the hope that it will be useful,
 *   but WITHOUT ANY WARRANTY; without even the implied warranty of
 *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *   GNU General Public License for more details.
 *
 *   You should have received a copy of the GNU General Public License
 *   along with Nextflow.  If not, see <http://www.gnu.org/licenses/>.
 */

params.pairs = "$baseDir/data/ggal/*_{1,2}.fq"


Channel
    .fromFilePairs( params.pairs )                                     
    .ifEmpty { error "Cannot find any reads matching: ${params.pairs}" }  
    .set { read_pairs }
    
    
process mapping {    
    input:
    set pair_id, file(reads) from read_pairs
  
    output:
    set pair_id, "hits.bam" into bam
  
    """
    echo tophat2 genome.index ${read1} ${read2}
    echo 'dummy' > hits.bam
    """
}    

bam.println()