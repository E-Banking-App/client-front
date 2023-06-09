import { Component } from '@angular/core';
import {CreditorService} from '../services/creditor/creditor.service'
import { Router } from '@angular/router';

@Component({
  selector: 'app-home',
  templateUrl: './home.component.html',
  styleUrls: ['./home.component.scss']
})
export class HomeComponent {

  creditorsDonation: any[] = [];
  creditorsFacture: any[] = [];
  creditorsRecharge: any[] = [];

  constructor(private creditorService: CreditorService, private router: Router) { }

  newDonationName: string | undefined;

  openDonationComponent(name: string): void {
    this.newDonationName = name;
    console.log(this.newDonationName)
    this.router.navigate(['/donation', this.newDonationName]);
  }

  newFactureCreancier: string | undefined;
  newFactureCreance: string | undefined;

  openFactureComponent(creancier: string, creance: string): void {
    this.newFactureCreancier = creancier;
    this.newFactureCreance = creance;
    console.log(this.newFactureCreance)
    console.log(this.newFactureCreancier)
    this.router.navigate(['/facture', this.newFactureCreancier, this.newFactureCreance]);
  }

  ngOnInit(): void {
    this.getCreditorsOfDonation();
    this.getCreditorsOfFacture();
    this.getCreditorsOfRecharge();
  }

  getCreditorsOfDonation(): void {
    this.creditorService.getCreditorsOfDonation().subscribe({
      next: (data: any) => {
        console.log(data)
        this.creditorsDonation = data;
      },
      error: (e: any) => {
        console.log(e)
      },
    })
  }

  getCreditorsOfFacture(): void {
    this.creditorService.getCreditorsOfFacture().subscribe({
      next: (data: any) => {
        console.log(data)
        this.creditorsFacture = data;
      },
      error: (e: any) => {
        console.log(e)
      },
    })
  }
  getCreditorsOfRecharge(): void {
    this.creditorService.getCreditorsOfRecharge().subscribe({
      next: (data: any) => {
        console.log(data)
        this.creditorsRecharge = data;
      },
      error: (e: any) => {
        console.log(e)
      },
    })
  }

}
