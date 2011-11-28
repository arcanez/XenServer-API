package XenServer::API::Guest;
use Moose;
#use Moose::Util::TypeConstraints qw(enum);

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
  isa => 'Int',
);

has resident_on => (
  is => 'ro',
);

has power_state => (
  is => 'ro',
#  isa => enum( qw(Halted Paused Running Suspended Unknown) ),
);

has other_config => (
  is => 'ro',
  isa => 'HashRef',
);

has allowed_operations => (
  is => 'ro',
  isa => 'ArrayRef',
);

__PACKAGE__->meta->make_immutable;
no Moose;
1;
