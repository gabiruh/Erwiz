package Erviz::Parser;
use 5.010;
use Moose;
use Regexp::Grammars;

use Erviz::ERD::Entity;
use Erviz::ERD::Attribute;
use Erviz::ERD::Option;

my $grammar = qr{
  # <logfile: parser_log>
  #  <debug: on>
  <nocontext:>
  <erd>

  <rule: erd>                   <[element]>+ ** <.ws>
  <rule: element>               <entity> | <relationship> | <header>
  <rule: header>                \{ title \: "<[title]>" ; <[header_options]>* \}
  <rule: header_options>         <[option]> ** ;
  <rule: title>                 [^"]*

  <objrule: Erviz::ERD::Entity=entity>                \[ <name=entity_name> \] <options>? \n
                                <.ws> <[attributes=attribute]>* ** \n
                                (?{ $MATCH{name} = $MATCH{name}{identifier}})

  <rule: entity_name>           <identifier>

  <rule: options>               \{ <[option]> ** ; \} (?{ $MATCH = $MATCH{option}})
  <objrule: Erviz::ERD::Option=option>                <key> : <value> 
  <token: key>                  \w[\w-]*
  <token: value>                ".*?"|\w+|\d+

  <objrule: Erviz::ERD::Attribute=attribute>             <primarykey>? <name=attribute_name> <foreignkey>? 
                                <options>?

  <token: primarykey>           \* (?{ $MATCH = 1 })
  <token: foreignkey>           \* (?{ $MATCH = 1 })

  <rule: attribute_name>        <identifier> (?{ $MATCH = $MATCH{identifier}})

  <rule: relationship>            <first_rel_entity> <cardinality> 
                                  <second_rel_entity> <rel_opt_attr>

  <rule: first_rel_entity>        <rel_entity> 
                                  (?{ $MATCH = $MATCH{rel_entity}{entity_name}{identifier}})

  <rule: second_rel_entity>       <rel_entity>
                                  (?{ $MATCH = $MATCH{rel_entity}{entity_name}{identifier}})
  <rule: rel_opt_attr>            <verb>? <rel_option>?

  <rule: rel_entity>              \[ <entity_name> \]
  <rule: cardinality>              <first=first_cardinality_symbol>--<second=second_cardinality_symbol>

  <rule: first_cardinality_symbol>  <cardinality_symbol> 
                                    (?{ $MATCH = $MATCH{cardinality_symbol}})

  <rule: second_cardinality_symbol>  <cardinality_symbol>
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
                                <right_left> (?{ $MATCH = 'right_left'; })
  <rule: left_right>            <identifier> <dash>
  <rule: right_left>            <dash> <identifier>
  <token: dash>                 -

  <rule: rel_option>            <[options]>?
  <token: identifier>           [^[][\w ]+
  <token: ws>                   (?: \s+ | \#[^\n]* )*
}xms;

sub parse {
  my ( $self, $input ) = @_;
  return \%/ if $input =~ $grammar;
}
