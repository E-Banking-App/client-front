import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import {Api} from "../../utils/api"

@Injectable({
  providedIn: 'root'
})
export class LoginService {
  constructor(private http: HttpClient) { }

  postLogIn(data: any) {
    return this.http.post<any>(`${Api}/auth/authenticate`, data)
  }
}
