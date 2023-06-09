import { Injectable } from '@angular/core';
import { HttpClient, HttpHeaders } from '@angular/common/http';
import {Api} from "../../utils/api"

@Injectable({
  providedIn: 'root'
})
export class CreditorService {
  constructor(private http: HttpClient) { }

  getCreditorsOfRecharge() {
    const token = localStorage.getItem('token');
    const headers = new HttpHeaders().set('Authorization', `Bearer ${token}`);

    return this.http.get<any>(`${Api}/creditor/recharge`, {headers})
  }

  getCreditorsOfFacture() {
    const token = localStorage.getItem('token');
    const headers = new HttpHeaders().set('Authorization', `Bearer ${token}`);

    return this.http.get<any>(`${Api}/creditor/facture`, {headers})
  }

  getCreditorsOfDonation() {
    const token = localStorage.getItem('token');
    const headers = new HttpHeaders().set('Authorization', `Bearer ${token}`);

    return this.http.get<any>(`${Api}/creditor/donation`, {headers})
  }
}
