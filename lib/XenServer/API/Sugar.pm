package XenServer::API::Sugar;
use Moose::Role;

has guests => (
  is => 'ro',
  lazy => 1,
  builder => '_build_guests',
  isa => 'ArrayRef',
);

sub _build_guests {
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
    push @return, XenServer::API::Guest->new($vm);
  }
  return \@return;
}

no Moose::Role;
1;
