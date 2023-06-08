import { NgModule } from '@angular/core';
import { BrowserModule } from '@angular/platform-browser';
import { MatSlideToggleModule } from '@angular/material/slide-toggle';
import { AppComponent } from './app.component';
import { LoginComponent } from './login/login.component';
import {MatCardModule} from "@angular/material/card";
import {ReactiveFormsModule} from "@angular/forms";
import {MatFormFieldModule} from "@angular/material/form-field";
import {MatButtonModule} from "@angular/material/button";
import {MatIconModule} from "@angular/material/icon";
import {MatInputModule} from "@angular/material/input";
import {RouterModule, RouterOutlet, Routes} from "@angular/router";
import { HomeComponent } from './home/home.component';

import {MatToolbarModule} from "@angular/material/toolbar";
import { FactureComponent } from './facture/facture.component';
import { NavbarComponent } from './navbar/navbar.component';
import { BrowserAnimationsModule } from '@angular/platform-browser/animations';
import { UserinfoComponent } from './userinfo/userinfo.component';
import { PayementComponent } from './payement/payement.component';

import {HttpClientModule} from '@angular/common/http'
import { AuthGuardGuard } from './guards/auth-guard.guard';


const routes: Routes = [
  { path: '', component: LoginComponent },
  { path: 'home', component: HomeComponent, canActivate: [AuthGuardGuard]},
  { path: 'facture', component: FactureComponent, canActivate: [AuthGuardGuard]},
  { path: 'userinfo', component: UserinfoComponent, canActivate: [AuthGuardGuard]},
  { path: 'payment', component: PayementComponent, canActivate: [AuthGuardGuard]}
];

@NgModule({
  declarations: [
    AppComponent,
    LoginComponent,
    HomeComponent,
    FactureComponent,
    NavbarComponent,
    UserinfoComponent,
    PayementComponent,

  ],
  imports: [
    BrowserModule,
    MatSlideToggleModule,
    MatCardModule,
    ReactiveFormsModule,
    MatFormFieldModule,
    MatButtonModule,
    MatIconModule,
    MatInputModule,
    RouterOutlet,
    RouterModule.forRoot(routes),
    MatToolbarModule,
    BrowserAnimationsModule,
    HttpClientModule
  ],
  providers: [],
  bootstrap: [AppComponent]
})
export class AppModule { }
