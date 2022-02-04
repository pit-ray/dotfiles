#!/usr/bin/env perl

$latex = 'platex -synctex=1 -halt-on-error -interaction=nonstopmode -file-line-error %O %S' ;
$bibtex = 'pbibtex %O %S';
$biber = 'biber --bblencoding=utf8 -u -U --output_safechars %O %S';
$makeindex = 'mendex %O -o %D %S';
$dvipdf = 'dvipdfmx %O -o %D %S';

$max_repeat = 5;
$pdf_mode = 3;

$pvc_view_file_via_temporary = 0;
if ($^O eq 'linux') {
    $dvi_previewer = 'xdg-open %S';
    $pdf_previewer = 'xdg-open %S';
} elsif ($^O eq 'darwin') {
    $dvi_previewer = 'open %S';
    $pdf_previewer = 'open %S';
} else {
    $dvi_previewer = 'start %S';
    $pdf_previewer = 'sumatrapdf -reuse_instance %S';
}

$clean_ext = '%R.synctex.gz';

$out_dir = 'out';
