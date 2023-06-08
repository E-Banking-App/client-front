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
    phonenumber: new FormControl('', [Validators.required, Validators.minLength(10)]),
    password: new FormControl('', [Validators.required, Validators.minLength(8)])
  })

  onSubmit() {
    if(this.LoginForm.valid) {
      console.log(this.LoginForm.value);
      this.api.postLogIn(this.LoginForm.value).subscribe({
        next: (result : any) => {
          console.log("User Sign In Successfully", result);
          localStorage.setItem('token', result.token);
          this.LoginForm.reset()

          // Redirection vers la page de changement de mot de passe
          if (result.isFirstLogin == true){
            this.router.navigateByUrl('/password');
          }
          else{
            this.router.navigateByUrl('/home');
          }
        },
        error: (err: any)=> {
          console.error("Something went wrong", err)
        }
      })
    }
  }

}
