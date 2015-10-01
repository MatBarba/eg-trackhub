
# in this cript I connect to the trackHub Registry db and I register (upload) a track hub

  use strict ;
  use warnings;
  use Data::Dumper;

  use HTTP::Tiny;
  use Time::HiRes;
  use JSON;
  use MIME::Base64;
  use HTTP::Request::Common;
  use LWP::UserAgent;

  my $ua = LWP::UserAgent->new;

# example call:
#perl trackHubRegistry.pl ensemblplants http://www.ebi.ac.uk/~tapanari/data/test/SRP036860/hub.txt JGI2.0 GCA_000002775.2

  my $pwd = $ARGV[0]; # i pass the pwd when calling the pipeline, in the command line  # it is ensemblplants
  my $trackHub_txt_file_url= $ARGV[1];
  my $assembly_name = $ARGV[2];   # this is the Ens assembly name ie  JGI2.0 
  my $assembly_accession = $ARGV[3];  # i put here the INSDC assembly accession  ie GCA_000002775.2

  my $server = "http://193.62.54.43:3000";
 
  my $endpoint = '/api/login';
  my $url = $server.$endpoint; 
  my $request = GET($url) ;

  $request->headers->authorization_basic('etapanari', $pwd);
  # print Dumper $request;
  my $response = $ua->request($request);

  my $auth_token = from_json($response->content)->{auth_token};
  
  $url = $server . '/api/trackhub';

  my $eg_server = "http://rest.ensemblgenomes.org";
  my $endpoint_eg_assembly_accession = "/info/assembly/populus_trichocarpa?content-type=application/json"; 

  $request = POST($url,
		  'Content-type' => 'application/json',
		  'Content' => to_json({ url => $trackHub_txt_file_url, type => 'transcriptomics', assemblies => { "$assembly_name" => "$assembly_accession" } }));
  $request->headers->header(user => 'etapanari');
  $request->headers->header(auth_token => $auth_token);

  $response = $ua->request($request);
  print Dumper ($response);

  