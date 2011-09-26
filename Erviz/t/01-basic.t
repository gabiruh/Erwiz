use Test::More;
use Data::Dump;
BEGIN {use_ok 'Erviz::Parser'};

my $text = q/[Area] { mark: "<ext.>"; color: green }

[Order]
*Order ID
 Customer ID*
 Order Date

[Bar]
Customer ID*
Order Date

[Biz]
[  Foo]
*Quux ID
 Bar ID*

[Quux  ]

[Department]
*Quux ID
 Bar ID*


[Employee] *--? [Department] <-foo>
[Foo  ] 1--* [  Bar] <quux for bar->
/;

my $t2 = q/
[Order]
*Order ID
 Customer ID*
 Employee ID*
 Order Date

[Order Detail]
*Order Detail ID
 Order ID*
 Product ID*
 Quantity
 Unit Price
 Discount

[Product] {mark: "<change>"; color: orange}
*Product ID
 Product Name
 Standard Price
 Product Category ID* {mark: "<new>"}

[Package Deal]
*Package ID*
*Member ID*
 Quantity

[Product Category] {mark: "<new>"; color: red}
*Product Category ID
 Product Category Name
 Parent Category ID*

[Employee]
*Employee ID
 First Name
 Last Name
 Address
 Phone Number
 Department ID*
 Supervisor ID*

[Department]
*Department ID
 Department Name
 Area ID*

[Area] {mark: "<ext.>"; color: green}

[Supplier]
*Supplier ID
 Supplier Name
 Area ID*

[Product Supplier]
*Product ID*
*Supplier ID*
*Sequence Number
 Begin Date
 End Date

[Customer] {color: blue}
*Customer ID
 First Name
 Last Name
 Phone Number
 Address
 Area ID*

[Customer Detail] {mark: "<abbr.>"; color: blue}

[Shipping]
*Shipping ID
 Order ID*
 From Area ID*
 To Area ID*


#
# Relationships
#

[Product] *--1 [Product Category]

[Product Category] *--1 [Product Category]

[Order] *--1 [Customer] <-places>

[Order] *--1 [Employee]

[Order] 1--* [Shipping]

[Order] 1--+ [Order Detail] <contains>

[Shipping] *--+ [Area] {N2: "2"}

[Order Detail] *--1 [Product]

[Employee] *--1 [Department] <belongs->

[Product] 1--* (Product Supplier) {N1: "1"; N2: "N"}

[Supplier] 1--* (Product Supplier) {N1: "1"; N2: "N"}

[Employee] *--? [Employee] <-supervises>

[Department] *--? [Area]

[Customer] *--? [Area]

[Customer] 1--? (Customer Detail)

[Product] 1--? (Package Deal) <is registered as a package deal->

[Product] 1--* (Package Deal) <is contained as a member->
/;

my $parser = new_ok('Erviz::Parser');

ok(my $tree = $parser->parse($t2), 'parsed ok');

warn dd $tree;

# my $text = q/
#   [Area {mark: "<ext.>"; color: green}
# /;

# ok(!$parser->parse($text), 'worng!!1');
done_testing;
