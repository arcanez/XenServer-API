package XenServer::API::Guest;
use Moo;
use Scalar::Util qw(looks_like_number);
use Sub::Quote qw(quote_sub);

has name => (
  is => 'rw',
  init_arg => 'name_label',
  required => 1,
);

has uuid => (
  is => 'ro',
  required => 1,
);

has domid => (
  is => 'ro',
  required => 1,
  isa => quote_sub q{ die "$_[0] is not a valid DOM id" unless Scalar::Util::looks_like_number($_[0]) },
);

has other_config => (
  is => 'ro',
  isa => quote_sub q{ die "$_[0] is not a HASH ref" unless ref($_[0]) eq 'HASH' },
);

has allowed_operations => (
  is => 'ro',
  isa => quote_sub q{ die "$_[0] is not an ARRAY ref" unless ref($_[0]) eq 'ARRAY' },
);

1;
