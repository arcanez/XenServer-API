package XenServer::API;
use Moo;
use XML::RPC;
use Sub::Quote qw(quote_sub);
use XenServer::API::Guest;

with 'XenServer::API::Sugar';

has host => (
  is => 'rw',
  required => 1,
);

has username => (
  is => 'rw',
  required => 1,
);

has api_version => (
  is => 'rw',
  lazy => 1,
  default => sub { '1.2.0' },
);

has password => (
  is => 'rw',
  required => 1,
);

has _xmlrpc => (
  is => 'rw',
  lazy => 1,
  builder => '_build_xmlrpc',
  handles => [ qw(call) ],
  isa => quote_sub q{ die "$_[0] is not an XML::RPC object" unless $_[0]->isa('XML::RPC') },
);

has _session => (
  is => 'rw',
  lazy => 1,
  builder => '_build_session',
);

sub _build_xmlrpc {
  my $self = shift;
  my $xmlrpc = XML::RPC->new( $self->host );
  return $xmlrpc;
}

sub _build_session {
  my $self = shift;
  my $result = $self->call( 'session.login_with_password', $self->username, $self->password, $self->api_version );
  return $result->{Status} eq 'Success' ? $result->{Value} : '';
}

sub get {
  my $self = shift;
  $self->call( shift, $self->_session, @_ );
}

1;
