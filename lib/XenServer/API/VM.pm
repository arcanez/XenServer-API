package XenServer::API::VM;
use namespace::autoclean;
use Moose;
use Moose::Util::TypeConstraints qw(enum);
use MooseX::Types::Moose qw(Str Int HashRef ArrayRef Maybe Undef Bool);
use MooseX::Types::UUID qw(UUID);
use MooseX::UndefTolerant::Attribute;

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
  isa => Undef|Str,
);

has allowed_operations => (
  is => 'ro',
  isa => ArrayRef[Str],
);

has bios_strings => (
  is => 'ro',
  isa => HashRef,
  traits => [ qw(MooseX::UndefTolerant::Attribute) ],
  default => sub { +{} },
);

has blobs => (
  is => 'ro',
  isa => HashRef,
  traits => [ qw(MooseX::UndefTolerant::Attribute) ],
  default => sub { +{} },
);

has blocked_operations => (
  is => 'rw',
  isa => HashRef,
  traits => [ qw(MooseX::UndefTolerant::Attribute) ],
  default => sub { +{} },
);

has children => (
  is => 'ro',
  isa => ArrayRef[Str],
);

has consoles => (
  is => 'ro',
  isa => ArrayRef[Str],
);

has crash_dumps => (
  is => 'ro',
  isa => ArrayRef[Str],
);

has current_operations => (
  is => 'ro',
  isa => HashRef,
  traits => [ qw(MooseX::UndefTolerant::Attribute) ],
  default => sub { +{} },
);

has domarch => (
  is => 'ro',
  isa => Str,
  traits => [ qw(MooseX::UndefTolerant::Attribute) ],
  default => sub { '' },
);

has domid => (
  is => 'ro',
  isa => Int,
);

has guest_metrics => (
  is => 'ro',
  isa => Str,
);

has ha_always_run => (
  is => 'ro',
  isa => Bool,
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

1;
