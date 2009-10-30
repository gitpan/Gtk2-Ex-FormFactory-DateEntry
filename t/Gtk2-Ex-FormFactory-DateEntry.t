#!/usr/bin/perl -w
use strict;
use warnings;

use lib qw(../lib);
use Test::More 'no_plan';

use_ok 'Gtk2::Ex::FormFactory::DateEntry';

use Gtk2 '-init';
use Gtk2::Ex::FormFactory;

package Test::Object;
use Moose;
use MooseX::FollowPBP;

has 'attribute' => (is => 'rw', default => '2009-01-01');

package main;

my $object = Test::Object->new;

my $context = Gtk2::Ex::FormFactory::Context->new;
$context->add_object(
    name       => 'object' ,
    object     => $object  ,
    default_get_prefix  => undef,
    attr_accessors_href => {
        get_image => sub {
            return 'user.png';
        },
        get_employee_number => sub { return $_[0]->employee_number  },
        get_first_name      => sub { $_[0]->first_name  },
        get_middle_name     => sub { $_[0]->middle_name },
        get_last_name       => sub { $_[0]->last_name   },
        get_note            => sub { $_[0]->note        },
    },
);

my $dialog  = Gtk2::Ex::FormFactory->new (
    context  => $context,
    content => Gtk2::Ex::FormFactory::Window->new(
        title   => 'Gtk2::Ex::FormFactory::DateEntry Test',
        content => [
            Gtk2::Ex::FormFactory::DateEntry->new(
                attr => 'object.attribute',
            ),
            Gtk2::Ex::FormFactory::DialogButtons->new,
        ],
    ),
);

ok($dialog, 'form factory created');