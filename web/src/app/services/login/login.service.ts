import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Api } from "../../utils/api"
import { Observable } from 'rxjs';

@Injectable({
  providedIn: 'root'
})
export class LoginService {
  constructor(private http: HttpClient) { }

  postLogIn(data: any): Observable<any> {
    return this.http.post<any>(`${Api}/auth/authenticate/client`, data)
  }
}
