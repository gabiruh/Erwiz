package Erviz::Parser;
use 5.010;
use Moose;
use Regexp::Grammars;
use Data::Dump;
my $grammar = qr{
  # <logfile: parser_log>
  # <debug: on>

  <ERD>

  <rule: ERD>                   <[Entity]>+ \n <Relationships>?

  <rule: Entity>                <EntityName> <Options>? \n <Attributes>?

  <rule: EntityName>            \[ <identifier> \]

  <rule: Options>               \{ <[Option]> ** ; \}
  <rule: Option>                <key> : <value>
  <token: key>                  \w+
  <token: value>                ".*?"|\w+

  <rule: Attributes>            <[Attribute]>+ ** \n
 
  <rule: Attribute>             <primarykey>? <AttributeName> <foreignkey>?
  <token: primarykey>           \*
  <token: foreignkey>           \*

  <rule: AttributeName>         <identifier>

  <rule: Relationships>         <[Relationship]>+
  <rule: Relationship>          <FirstRelEntity> <Cardinality> <SecondRelEntity> <RelOptAttr>

  <rule: FirstRelEntity>        <RelEntity>
  <rule: SecondRelEntity>       <RelEntity>

  <rule: RelOptAttr>            <Verb>? <RelOption>?

  <rule: RelEntity>             <EntityName>
  <rule: Cardinality>           <FirstCardinalitySymbol> -- <SecondCardinalitySymbol>
  <rule: FirstCardinalitySymbol> <CardinalitySymbol>
  <rule: SecondCardinalitySymbol> <CardinalitySymbol>

  <rule: CardinalitySymbol>     <OneOptional>|<OneMandatory>|<ManyOptional>|<ManyMandatory>
  <token: OneOptional>          \?
  <token: OneMandatory>         1

  <token: ManyMandatory>        \+
  <token: ManyOptional>         \*
 
  <rule: Verb>                  \< <VerbDirection> \>
  <rule: VerbDirection>         <LeftRight> | <RightLeft>
  <rule: LeftRight>             <identifier> <dash>
  <rule: RightLeft>             <dash> <identifier>
  <token: dash>                 -

  <rule: RelOption>             <Options>
  <token: identifier>           [\w ]+ #\w+(?: \w+)

}xms;

sub parse {
  my ( $self, $input ) = @_;
  return \%/ if $input =~ $grammar;
}
