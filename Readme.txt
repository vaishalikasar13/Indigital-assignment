Readme file of Assignment

************ TASK1 USER REGISTRATION ************



1.Once the project setup has been done.run the project.
2.On the landing page you will see 2 buttons.click on user registration.
3.After that you will see  list of registered user.click on register.
4.user registration page will open.

************ INTERNAL WORKING OF TASK1 ************

1.You will see http://localhost:8000/create-user URL (vary according to your port no.)

2.(create-user) a user friendly url.here routing mechanism comes in the picture.
	i.Location --LARAVEL_ROOT/routes/web.php
	ii.usage --
	Route::get('create-user', function () 
	{
    return view('create-user');
	});
	iii.return view('create-user') is the view name that we have to show  whenever  http://localhost:8000/create-use will get called.

3.Views 
	i.location--LARAVEL_ROOT/resources/views/create-user.blade.php 
	ii.what is .blade after view name --Blade is the simple, yet powerful templating engine provided with Laravel.
	iii.use of blade template--- for reducing or simplifying the code that you write in your view
	e.g     <?php echo strtoupper('hello') ?>(PHP VIEW .php ) ==   {{strtoupper('hello')}} (BLADE VIEW .blade.php).

	1.create user view
	  i.Simple registration form with fields name,email,contact etc
	  ii.Included files 
	  	  - style.css (LARAVEL_ROOT/public/css/style.css) for styling.
	  	  - style.css (LARAVEL_ROOT/public/js/jquery.validate.min.js) & create-user.js for validation and form submission to server side.
	  iii.In view at top include <meta name="csrf-token" content="{{ csrf_token() }}"> this line
	  	  i.Cross-Site-Request-Forgery
	  	  ii.why ?  protect your application from cross-site request forgery (CSRF) attacks. 
	  iv.Captcha REF-https://packagist.org/packages/bonecms/laravel-captcha
	  	  i. Step 1. Install package
	  	  		composer require bonecms/laravel-captcha
	  	  ii.Step 2. Register the Laravel Captcha service provider
	  	  		LARAVEL_ROOT/config/app.php:
	  	  		Igoshev\Captcha\Providers\CaptchaServiceProvider::class,
	  	  iii.Showing a Captcha in a View
	  	  	 @captcha
	  	  iv.password stregth REF-https://www.formget.com/password-strength-checker-in-jquery/  code added in create-user.js  file.

	 2. Client side Form validation
	 	i.include jquery.validate.min.js for validation.
	 	ii.create-user.js
	 		1.write your form id to validate form -- $("#create-user-form").validate({
	 		2.ignore: 'input[type="hidden"]', to ignore hidden fields
	 		3.rules = write the validation you want inside the rules
	 			 rules: {
				   usr_email: {
      			  required: true,
				  email:true,
				  remote: {
				  type: 'post',
				  url: 'validate-email',
				  data: {
				    'usr_email': function () { return $('#usr_email').val(); }
				},
				dataType: 'json',
				headers: { 'X-CSRF-TOKEN': $('meta[name="csrf-token"]').attr('content') },
				  cache: false,
				}
				}, 
				usr_mobile: {
     		 	regex: /^[1-9]{1}[0-9]{9}$/,
   				}, 
				},
				usr_email--name of input
				required:true--it will make sure that your field should be mandatory before submitting data.you can write require in input too <input type="email" required placeholder="Enter Email" name="usr_email" id="usr_email">
				email:true--to get valid email address like vaishalikasar13@gmail.com
				remote: It is used to do server side validation.To check this email id is already exist or not.it returns boolean value from server side.true means user is new and false means existing user.
					regex:To validate mobile no.customized validation for that.To use this we have to add this method before validation. 

					$.validator.addMethod(
						 "regex",
						 function(value, element, regexp) {
		   			 var check = false;
		   			 return this.optional(element) || regexp.test(value);
					 },);

					 url:'validate-email',
					 In route-Route::post('validate-email', 'UserController@validateEmail');
				4.  messages=customized messages 

					  messages: {

					      usr_email: {
					      required: "Enter your email.",
					      email: "Enter valid email.",
					      remote: "Email has already been used. Please use another Email address.",
					      }, 

				5.errorPlacement=User defined place where error msg will get displayed

					  errorPlacement: function(error, element){
   					 error.appendTo( element.next('.help-block') );
  						},

  				6.submitHandler=Use to submit data after successful validation.

  						i.dataString=$('#create-user-form').serialize();
  							-The serialize() method creates a URL encoded text string by serializing form values.
  						ii.$.ajax({ =to submit data.
  						iii.type:'POST'
  							-For a request-response between a client and server.
  						iv.data: dataString, it contains all the filds values data like email,mobile.
  						v.dataType: 'json', serializing and transmitting structured data over a network connection.
  						vi. headers: { 'X-CSRF-TOKEN': $('meta[name="csrf-token"]').attr('content') }, 
  							-to submit form through ajax add the CSRF in the header of the ajax call otherwise system we through 419 status.we added that line in view too.
  						vii.  cache: false,=By setting the cache property to false jQuery will append a timestamp to the URL, so the browser won't cache it.
  						viii.beforeSend: function(){  $('#form_submit').html('<i class="fa fa-circle-o-notch fa-spin" style="font-size:18px"></i> Processing');$('#form_submit').attr('disabled','disabled'); },
  								-The action we have to take before submitting data.Here we are changing the button text from submit to processing and  disabling the button.So that user unable to click button more than once.Preventing from multiple entries.
  						ix.url: "insert-user",

  				7.Now controller to insert data--- UserController@createUser ---LARAVEL_ROOT/app/Http/Controllers/UserController.php
  						i.Server side validations Validation :-Here we are using inbuild validation library of laravel.
  							1.$input = Input::only('usr_name','usr_email',)=The input fields we have to validate.
  							2. $messsages = array('usr_name.required'=>"Enter your name.", 'usr_email.required'=>"Enter your email.")=For customized messages.
  							3. $rules = array(
   								  'usr_mobile' => ['required','min:10','max:10',Rule::unique('users', 'usr_mobile')->where(function($query) {$query->where('usr_mobile', $_POST['usr_mobile']);})],
							      'usr_email' =>['required', 'email', Rule::unique('users', 'usr_email')->where(function($query) {$query->where('usr_email', $_POST['usr_email']);})]);
							      	-Specify the validation you want in the rules.
							      	-Rule::unique=To check data is already exist or not.
							4.$validator = Validator::make($input , $rules,$messsages);=TO validate.
							5. if ($validator->passes())
							{
								Write insertion code.
								For e.g
								   $user->usr_company_size = Input::post('usr_company_size');---post because we have written  type: 'post', while making ajax request.(It can be get).
     							   $user->usr_status =   env('ACTIVE_STATUS');--Because we have to use this variable globally.That contains 1 values.
     							   	--How to declare  LARAVEL_ROOT/.evn file --ACTIVE_STATUS=1
     							$user->save();=to save data in database.
     							How to store data in session= array('ass_usr_id' => $user->id,'ass_usr_name'  => Input::get('usr_name'),);Session::push('user', $userdata);
     							How to get stored values in the session={{ Session::get('user')[0] ['ass_usr_name']}}
     							After successful insertion we will send  response to ajax to proceed further in json format.
     								-  echo json_encode(array("success"=>true,"message"=>"Added new records.","linkn"=>'users'));
							}
							else
							{
							echo json_encode(array("success"=>false,"message"=>$validator->errors()->all(),"error_type"=>'user'));
							send error msg to ajax response.It will get display on view page.
							}

					8.Ajax response
						i.response can be either true or false.
						 	success: function(response)
						  	{if(response.success==true){ window.location.href=response.linkn;}}=if response is true then we redirect the user to user list view.


	************ TASK2 SLACK INTEGRATION ************	REF-https://laracasts.com/series/whats-new-in-laravel-5-3/episodes/11	
1.http://localhost:8000/ Hit this URL
2.Now click on Slack Integration Button
3.You be redirected to http://localhost:8000/slack this URL
	i.This form will take slack webhook URL to get error notification.
	ii.After getting slack webhook url user will be redirected to http://localhost:8000/slack-testing this URL
	iii.One form will get open that will take name & contact from user.
	iv.After submitting form
4.Controller to send notifications Route::post('slack-testing', 'UserController@slackTesting');
5.Inside Controller
	i. try
   {
    DB::table('slack')->insert(
    array('slk_usr_name' => Input::post('slk_usr_name'),
          'slk_usr_mobile1' => Input::post('slk_usr_mobile')));
    echo json_encode(array("success"=>true,"message"=>"Data has been inserted successfully."));
    }
  catch (\Exception $e)
   {
   $admin = new User;
   $admin->notify(new errorNotifation($e->getMessage()));
   echo json_encode(array("success"=>false,"message"=>"Check your slack messanger.You have received an notification about error."));
   }


ERROR CASE : Actual column name of table is slk_usr_mobile.
   -Here we are trying to insert Input::post('slk_usr_mobile')) value in the column that doesn't exist in the table.
   -So it will come inside the catch
   -To send notification you have to make notification file inside notifications folder
   		How to create- command-  php artisan make:notification errorNotification   location- (LARAVEL_ROOT/app/Notifications/errorNotification.php)
   		1.Inside catch
   			-  $admin = new User;=instance of user model --model location- (LARAVEL_ROOT/app/Providers/user.php)
   			-  $admin->notify(new errorNotifation($e->getMessage()));
   			-errorNotification.php-- 
   				public function via($notifiable)
			    {
			        return ['slack']; --because we have to send slack nootification.we can write mail to send mails
			    }

			      public function toSlack($notifiable)
			   {
			   $notifiable --will get your webhook uRL that we took previously.
			     $msg = $this->msg;--To send slack msg.This msg contains error msg.
			      return (new SlackMessage)
			      ->success()
			      ->content($msg);
			   }

			   user model--
				 public function routeNotificationForSlack()
			    {
			       $data=DB::table('bsn_prm')->select('bpm_value')->where('bpm_name',env('SLACK_URL_BSN_NAME'))->first();
     				return  $data->bpm_value;
			    }
			 NOte:to receive notification you have to uncomment following line from xampp php.ini file & provide location of  cacert.pem file
			 curl.cainfo= "D:\xampp\php\extras\ssl\cacert.pem";
			 why? System will throw  "cURL error 60: SSL certificate problem: unable to get local issuer certificate (see http://curl.haxx.se/libcurl/c/libcurl-errors.html)"  ,msg if  cacert.pem not found
			 meaning: Transfer of sensitive information is typically done under the cover of digital certificates. The certificate will help confirm to the recipient that the sender is actually who they claim they are. Digital certificates are issued by certificate authorities.
			 cacert.pem download link: https://curl.haxx.se/ca/cacert.pem

						   	


















