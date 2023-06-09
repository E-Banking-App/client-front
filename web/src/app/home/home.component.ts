import { Component } from '@angular/core';
import {CreditorService} from '../services/creditor/creditor.service'

@Component({
  selector: 'app-home',
  templateUrl: './home.component.html',
  styleUrls: ['./home.component.scss']
})
export class HomeComponent {

  creditorsDonation: any[] = [];
  creditorsFacture: any[] = [];
  creditorsRecharge: any[] = [];

  constructor(private creditorService: CreditorService) { }

  ngOnInit(): void {
    this.getCreditorsOfDonation();
    this.getCreditorsOfFacture();
    this.getCreditorsOfRecharge();
  }

  getCreditorsOfDonation(): void {
    this.creditorService.getCreditorsOfDonation().subscribe({
      next: (data: any) => {
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
        this.creditorsRecharge = data;
      },
      error: (e: any) => {
        console.log(e)
      },
    })
  }

}
