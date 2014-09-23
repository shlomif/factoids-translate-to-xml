#!/usr/bin/perl

use strict;
use warnings;

use XML::LibXML;

my ($in_fn, $out_fn) = @ARGV;

my $p = XML::LibXML->new;

my $doc = $p->parse_file($in_fn);

my @nodes = $doc->findnodes('//he');

foreach my $n (@nodes)
{
    my @childs = $n->childNodes();
    my $elem = XML::LibXML::Element->new('f');
    my $l_en = XML::LibXML::Element->new('l');
    $l_en->setAttribute("xml:lang", "en-US");
    my $l_he = XML::LibXML::Element->new('l');
    $l_he->setAttribute("xml:lang", "he-IL");

    my @n_prevs;

    my $x = $n->previousSibling;
    while (($x->localname // '') ne 'en')
    {
        push @n_prevs, $x;
    }
    continue
    {
        $x = $x->previousSibling;
    }
    push @n_prevs, $x;

    for my $c (@childs)
    {
        $l_he->appendChild($c);
    }
    for my $c ($n_prevs[-1]->childNodes)
    {
        $l_en->appendChild($c);
    }

    $elem->appendChild($l_en);
    $elem->appendChild($l_he);

    my $parent = $n->parentNode;
    $parent->insertAfter($l_he, $elem);
    foreach my $c (@n_prevs, $l_he)
    {
        $c->unbindNode();
        # $parent->removeChild( $c );
    }
    print "\n<<<<<<<<<<<<\n$parent\n>>>>>>>>>>>\n";
=begin foo

    $parent->replaceChild(
        $elem,
        $l_he,
    );

=cut

}

use IO::All qw/ io /;
io->file($out_fn)->utf8->print($doc->toString);
