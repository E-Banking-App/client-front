import { Component } from '@angular/core';
import {FormControl, FormGroup, Validators} from "@angular/forms";

import {LoginService} from '../services/login/login.service'
import { Router } from '@angular/router';

@Component({
  selector: 'app-login',
  templateUrl: './login.component.html',
  styleUrls: ['./login.component.scss']
})
export class LoginComponent {
  hide = true;

  constructor(private api: LoginService, private router: Router) { }

  LoginForm = new FormGroup({
    username: new FormControl('', [Validators.required, Validators.minLength(10)]),
    password: new FormControl('', [Validators.required, Validators.minLength(8)])
  })

  onSubmit() {
    if(this.LoginForm.valid) {

      console.log(this.LoginForm.value);
      this.api.postLogIn(this.LoginForm.value).subscribe(
        response => {
          console.log('Client Authenticate:', response);
          // Handle success if needed

          // Assuming the token is returned as 'token' in the response
          const token = response.token;
          console.log(token)
          localStorage.setItem('token', token);//stock the token
          localStorage.setItem('id', response.id)

          // Redirection vers la page de changement de mot de passe
          if (response.isFirstLogin == true){
            this.router.navigateByUrl('/password');
          }
          else{
            this.router.navigateByUrl('/home');
          }
        },

        error => {
          console.error('Error Authenticate client:', error);
          // Handle error if needed

        }
      );

      console.log(this.LoginForm.value);
    }

    // if (this.firstLogin) {
    //   // Redirection vers la page de changement de mot de passe
    //   this.router.navigateByUrl('/password');
    // }
  }

}
