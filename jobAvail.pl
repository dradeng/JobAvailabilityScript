use v5.10;
use WWW::Mechanize;
use WWW::Mechanize::TreeBuilder;

my $mech = WWW::Mechanize->new;
WWW::Mechanize::TreeBuilder->meta->apply($mech);

while(TRUE){
	eval {
		$mech->get( 'http://ec2-18-222-64-213.us-east-2.compute.amazonaws.com/printAllBallots/12345678' );
		
		#$mech->click_button( id => "myButton");
		# Find all <h1> tags
		my @list = $mech->find('pre');


		# or this way
		my @list = $mech->look_down('_tag', 'pre');
		
		# Now just iterate and process
		my $filename = 'UnprintedBallots.txt';

		open(FH, '>', $filename) or die $!;

		foreach (@list) {
		    print FH $_->as_text();
		    system("py", "python_print_script.py") == 0 or die "Python script returned error $?";
		}
		close(FH);
		sleep 10;
	};
	if ($@) {
	}
}