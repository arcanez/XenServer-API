package XenServer::API::Sugar;
use Moo::Role;
use Sub::Quote qw(quote_sub);

has guests => (
  is => 'ro',
  lazy => 1,
  builder => '_build_guests',
  isa => quote_sub q{ die "$_[0] is not an arrayref" unless ref($_[0]) eq 'ARRAY' },
);

sub _build_guests {
  my $self = shift;
  my @return;
  my $results = $self->get('VM.get_all');
  return [] unless $results->{Status} eq 'Success';
  for my $uuid (@{$results->{Value}}) {
    my $vm = $self->get('VM.get_record', $uuid);
    next unless $vm->{Status} eq 'Success';
    next if $vm->{Value}{is_a_template};
    next if $vm->{Value}{is_a_snapshot};
    next if $vm->{Value}{is_control_domain};
    delete $vm->{Value}{last_booted_record};
    push @return, XenServer::API::Guest->new($vm->{Value});
  }
  return \@return;
}

1;
