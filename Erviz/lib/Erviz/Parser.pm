package Erviz::Parser;
use 5.010;
use Moose;
use Regexp::Grammars;
use Data::Dump;
my $grammar = qr{
#  <logfile: - >

  <ERD>

  <rule: ERD>                   <[Entity]>+ <Relationship>?
  <rule: Entity>                \[ <EntityName> \] <Options>? <Attributes>?

  <rule: EntityName>            <identifier>

  <rule: Options>               \{ <[Option]> ** ; \}
  <rule: Option>                <key> : <value>
  <token: key>                  \w+
  <token: value>                ".*?"|\w+

  <rule: Attributes>            <[Attribute]>+

  <rule: Attribute>             <primarykey>? <AttributeInfo> <foreignkey>?
  <token: primarykey>           \*
  <token: foreignkey>           \*

  <rule: AttributeInfo>         <Type>       <AttributeIdentifier>

  <rule: AttributeIdentifier>   <identifier>

  <rule: Type>                  <:EntityName>|<identifier>

  <rule: Relationship>          <identifier>

  <token: identifier>           \w+
}xms;

sub parse {
  my ( $self, $input ) = @_;
  return \%/ if $input =~ $grammar;
}
