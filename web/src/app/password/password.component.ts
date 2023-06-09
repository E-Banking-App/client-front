import { Component } from '@angular/core';
import { FormGroup, FormControl, Validators, ValidatorFn, AbstractControl } from '@angular/forms'
import { MatSnackBar, MatSnackBarHorizontalPosition, MatSnackBarVerticalPosition } from '@angular/material/snack-bar';
import { Route, Router } from '@angular/router';
import { PasswordService } from 'src/app/services/password/password.service';
function passwordMatchValidator(): ValidatorFn {
  return (control: AbstractControl): { [key: string]: any } | null => {
    const newPassword = control.get('newPassword');
    const confirmation = control.get('confirmation');

    if (newPassword && confirmation && newPassword.value !== confirmation.value) {
      return { 'passwordMismatch': true };
    }

    return null;
  };
}

@Component({
  selector: 'app-password',
  templateUrl: './password.component.html',
  styleUrls: ['./password.component.scss']
})


export class PasswordComponent {
  hide = true;

  constructor(private router: Router, private passwordService: PasswordService) { }

  //the id of the client connected
  createdBy_id = localStorage.getItem('id');

  newPasswordForm = new FormGroup({
      id: new FormControl(this.createdBy_id),
      newPassword: new FormControl('', [Validators.required, Validators.minLength(6)]),
      confirmation: new FormControl('', [Validators.required, Validators.minLength(6)])
    },
    { validators: passwordMatchValidator() } // Ajoutez la validation personnalisée au groupe de formulaires
  );





  onSubmit() {
    console.log(this.newPasswordForm.valid);
    if (this.newPasswordForm.valid) {
      console.log(this.newPasswordForm.value);


      this.passwordService.changePassword(this.newPasswordForm.value).subscribe(
        response => {
          console.log('Client saved:', response);
          // Handle success if needed

          this.newPasswordForm.reset()

          //redirecte
          this.router.navigateByUrl('/home');

        },

        error => {

          console.error('Error Changing Password:', error);

        }
      );

      console.log(this.newPasswordForm.value);
    }


  }
}
