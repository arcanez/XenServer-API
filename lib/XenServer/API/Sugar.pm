package XenServer::API::Sugar;
use Moo::Role;
use MooX::Types::MooseLike qw(ArrayRef);

has guest_vms => (
  is => 'ro',
  lazy => 1,
  builder => '_build_guest_vms',
  isa => ArrayRef,
);

sub _build_guest_vms {
  my $self = shift;
  my @return;
  my $results = $self->get('VM.get_all_records');
  return [] unless $results->{Status} eq 'Success';
  for my $key (keys %{$results->{Value}}) {
    my $vm = $results->{Value}{$key};
    next if $vm->{is_a_template};
    next if $vm->{is_a_snapshot};
    next if $vm->{is_control_domain};
    delete $vm->{last_booted_record};
    push @return, XenServer::API::VM->new($vm);
  }
  return \@return;
}

no Moo::Role;
1;
