import {Component, OnInit} from '@angular/core';

@Component({
  selector: 'app-userinfo',
  templateUrl: './userinfo.component.html',
  styleUrls: ['./userinfo.component.scss']
})
export class UserinfoComponent implements OnInit{
  userPassword: string = '';
  confirmPassword: string = '';

  constructor() {}

  ngOnInit(): void {}

  onConfirmClick() {
    if (this.userPassword !== this.confirmPassword) {
      alert('Les mots de passe ne correspondent pas.');
    } else {
      // update password ?
      alert('Mot de passe change.');
    }
  }

}
