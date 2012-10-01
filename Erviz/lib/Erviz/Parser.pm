package Erviz::Parser;
use warnings;
use strict;
use 5.010;

use Exporter 'import';
our @EXPORT_OK = qw(parse);

use Regexp::Grammars;

use Erviz::ERD::Entity;
use Erviz::ERD::Attribute;
use Erviz::ERD::Option;

my $grammar = qr{
   <logfile: parser_log>
    <debug: on>
  <nocontext:>
  <erd>

  <rule: erd>                   <[element]>+ ** <.ws>
  <rule: element>               <entity> | <relationship> | <header>
  <rule: header>                \{ title \: "<[title]>" ; <[header_options]>* \}
  <rule: header_options>         <[option]> ** ;  (?{ $MATCH = +{ map {@$_} @{$MATCH{option}}}})
  <rule: title>                 [^"]*

  <objrule: Erviz::ERD::Entity=entity>                \[ <name=entity_name> \] <options>? \n
                                <.ws> <[attributes=attribute]>* ** \n
                                (?{ $MATCH{name} = $MATCH{name}{identifier}})

  <rule: entity_name>           <identifier>

  <rule: options>               \{ <[option]> ** ; \} (?{ $MATCH = +{ map {@$_} @{$MATCH{option}}}})
  <rule: option>                <key> : <value> (?{ $MATCH = [$MATCH{key}, $MATCH{value}] })
  <token: key>                  \w[\w-]*
  <token: value>                ".*?"|\w+|\d+

  <objrule: Erviz::ERD::Attribute=attribute>             <primary_key>? <name=attribute_name> <foreign_key>? 
                                <options>?

  <token: primary_key>           \* (?{ $MATCH = 1 })
  <token: foreign_key>           \* (?{ $MATCH = 1 })

  <rule: attribute_name>        <identifier> (?{ $MATCH = $MATCH{identifier}})

  <rule: relationship>            <left_rel_entity> <cardinality> 
                                  <right_rel_entity> <rel_opt_attr>

  <rule: left_rel_entity>        <rel_entity> 

  <rule: right_rel_entity>       <rel_entity>
  <rule: rel_opt_attr>            <verb>? <rel_option>?

  <rule: rel_entity>              <rel_entity_rounded>|<rel_entity_squared> 
  <rule: rel_entity_rounded>      \( <entity_name> \)
                                  (?{ $MATCH = { name => $MATCH{entity_name}{identifier}, type => 'rounded'} })
  
  <rule: rel_entity_squared>      \[ <entity_name> \] 
                                  (?{ $MATCH = { name => $MATCH{entity_name}{identifier}, type => 'squared'} })
  
  <rule: cardinality>              <left=left_cardinality_symbol>--<right=right_cardinality_symbol>

  <rule: left_cardinality_symbol>  <cardinality_symbol> 
                                    (?{ $MATCH = $MATCH{cardinality_symbol}})

  <rule: right_cardinality_symbol>  <cardinality_symbol>
                                     (?{ $MATCH = $MATCH{cardinality_symbol}})

  <rule: cardinality_symbol>     <one_optional>   (?{ $MATCH = 'one_optional'; })   |
                                 <one_mandatory>  (?{ $MATCH = 'one_mandatory'; })  |
                                 <many_optional>  (?{ $MATCH = 'many_optional'; })  |
                                 <many_mandatory> (?{ $MATCH = 'many_mandatory'; }) |
                                 <any_relationship>   (?{ $MATCH = 'any_relationship'; }) |
  <token: one_optional>          \?
  <token: one_mandatory>         1

  <token: many_mandatory>        \+
  <token: many_optional>         \*
  <token: any_relationship>      -
 
  <rule: verb>                  \< <verb_direction> \>
                                (?{ $MATCH = $MATCH{verb_direction}})

  <rule: verb_direction>        <left_right> (?{ $MATCH = 'left_right'; }) |
                                <right_left> (?{ $MATCH = 'right_left'; })|
                                <no_direction> (?{ $MATCH = 'no_direction'; })
  <rule: no_direction>          <identifier>                                  
  <rule: left_right>            <identifier> <dash>
  <rule: right_left>            <dash> <identifier>
  <token: dash>                 -

  <rule: rel_option>            <[options]>?
  <token: identifier>           [^[][\w ]+
  <token: ws>                   (?: \s+ | \#[^\n]* )*
}xms;

sub parse {
  my ($input) = @_;
  return \%/ if $input =~ $grammar;
}
