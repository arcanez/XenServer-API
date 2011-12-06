package XenServer::API::VM;
use namespace::autoclean;
use Moose;
use Moose::Util::TypeConstraints qw(enum);
use MooseX::Types::Moose qw(Str Int HashRef ArrayRef Maybe);
use MooseX::Types::UUID qw(UUID);

has actions_after_crash => (
  is => 'rw',
  isa => enum( [ qw(destroy coredump_and_destroy restart coredump_and_restart preserve rename_restart)] ),
);

has actions_after_reboot => (
  is => 'rw',
  isa => enum( [ qw(destroy restart) ] ),
);

has actions_after_shutdown => (
  is => 'rw',
  isa => enum( [ qw(destroy restart) ] ),
);

has affinity => (
  is => 'rw',
  isa => Maybe[Str],
);

has allowed_operations => (
  is => 'ro',
  isa => ArrayRef,
);

has name => (
  is => 'rw',
  init_arg => 'name_label',
  required => 1,
);

has uuid => (
  is => 'ro',
  required => 1,
  isa => UUID,
  coerce => 1,
);

has domid => (
  is => 'ro',
  required => 1,
  isa => Int,
);

has resident_on => (
  is => 'ro',
);

has power_state => (
  is => 'ro',
  isa => enum( [ qw(Halted Paused Running Suspended Unknown) ] ),
);

has other_config => (
  is => 'ro',
  isa => HashRef,
);

__PACKAGE__->meta->make_immutable;
1;
