use v5.10;
use WWW::Mechanize;
use WWW::Mechanize::TreeBuilder;

my $mech = WWW::Mechanize->new;
WWW::Mechanize::TreeBuilder->meta->apply($mech);

while(TRUE){
	eval {
		#NEED TO CHANGE URL
		$mech->get( 'http://ec2-18-222-64-213.us-east-2.compute.amazonaws.com/printAllBallots/12345678' );
		
		#This fills in the form and submits it
		$mech->submit_form(
			form_name => 'myForm',
			fields => {
				'cx-login-clientid-valid' => '0',
				'cx-login-username-valid' => 'draden',
				'cx-login-password-valid' => 'gaffney'
			},
		);

		$mech->submit_form(
			form_name => 'searchBar',
			fields => {
				'text' => 'Coachella'
			},
		);
		$mech->set_fields('radio_group_name' => 'option');
		#picks 
		$mech->submit();
		sleep 10;
	};
	if ($@) {
	}
}