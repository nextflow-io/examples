#!/usr/bin/env nextflow

/*
 * Copyright (c) 2018, Centre for Genomic Regulation (CRG).
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 * 
 * The above copyright notice and this permission notice shall be included in all
 * copies or substantial portions of the Software.
 * 
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 * SOFTWARE.
 */

 /*
  * author Paolo Di Tommaso <paolo.ditommaso@gmail.com> 
  */

params.skip = false
params.input = "$baseDir/sample.fq.gz" 

Channel.fromPath(params.input).set{ input_ch }

(foo_ch, bar_ch) = ( params.skip 
                 ? [Channel.empty(), input_ch] 
                 : [input_ch, Channel.empty()] ) 

process foo {
  input:
  file x from foo_ch

  output:
  file('*.fastq') into optional_ch

  script:
  """
  < $x zcat > ${x.simpleName}.fastq
  """
}

process bar {
  echo true
  input: 
  file x from bar_ch.mix(optional_ch)
  """
  echo your_command --input $x
  """
}