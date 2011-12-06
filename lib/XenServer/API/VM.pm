package XenServer::API::VM;
use Moo;
use MooX::Types::MooseLike qw(Str Int HashRef ArrayRef);
use Sub::Quote qw(quote_sub);

has name => (
  is => 'rw',
  init_arg => 'name_label',
  required => 1,
);

has uuid => (
  is => 'ro',
  required => 1,
  isa => quote_sub q( die "$_[0] is not a valid UUID" unless $_[0] =~ /^[A-F0-9]{8}-[A-F0-9]{4}-[A-F0-9]{4}-[A-F0-9]{4}-[A-F0-9]{12}$/i ),
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
  isa => quote_sub q( die "$_[0] is not a valid power state" unless $_[0] =~ /^(Halted|Paused|Running|Suspended|Unknown)$/i ),
);

has other_config => (
  is => 'ro',
  isa => HashRef,
);

has allowed_operations => (
  is => 'ro',
  isa => ArrayRef,
);

no Moo;
1;
