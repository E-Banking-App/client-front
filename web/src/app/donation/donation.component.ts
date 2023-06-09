import { Component, OnInit } from '@angular/core';
import { ActivatedRoute } from '@angular/router';
import {FormControl, FormGroup, Validators} from "@angular/forms";
import {CreditorService} from '../services/creditor/creditor.service'

@Component({
  selector: 'app-donation',
  templateUrl: './donation.component.html',
  styleUrls: ['./donation.component.scss']
})
export class DonationComponent {

  amount: number| undefined;
  dataFromParent: string | null = "";

  constructor(private route: ActivatedRoute, private api: CreditorService,) {}

  ngOnInit(): void {
    this.dataFromParent = this.route.snapshot.paramMap.get('data');
    console.log(this.dataFromParent)
  }

  email =  localStorage.getItem('email')

  DonationForm = new FormGroup({
    amount: new FormControl('', [Validators.required]),
    creancier: new FormControl(this.route.snapshot.paramMap.get('data')),
    phoneNumber: new FormControl(this.email),
  })


  onSubmit() {
    if(this.DonationForm.valid) {
      console.log(this.DonationForm.value);
      this.api.postDonation(this.DonationForm.value).subscribe(
        response => {
          console.log(response);
          alert("Thank You")
        },
        error => {
          console.error( error);
        }
      );
    }
  }
}
