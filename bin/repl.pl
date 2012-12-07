#!/usr/bin/env perl

while( true )
{
	print ">> ";
	$line=<>;
	$value=eval( $line );
	$error=$@;
	if( $error ne "" ){ print $error; }else{ print "$value\n"; }
}
