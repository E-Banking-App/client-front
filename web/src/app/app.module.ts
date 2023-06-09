import { NgModule } from '@angular/core';
import { BrowserModule } from '@angular/platform-browser';
import { MatSlideToggleModule } from '@angular/material/slide-toggle';
import { AppComponent } from './app.component';
import { LoginComponent } from './login/login.component';
import {MatCardModule} from "@angular/material/card";
import {FormsModule, ReactiveFormsModule} from "@angular/forms";
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

import { HttpClientModule } from '@angular/common/http';
import { RechargeComponent } from './recharge/recharge.component';
import { DonationComponent } from './donation/donation.component';
import { HistoriqueComponent } from './historique/historique.component';
import { PayementpageComponent } from './payementpage/payementpage.component';
import { RechargepageComponent } from './rechargepage/rechargepage.component';
import { MatGridListModule } from '@angular/material/grid-list';



import { AuthGuardGuard } from './guards/auth-guard.guard';
import { PasswordComponent } from './password/password.component';
import { NotfoundComponent } from './notfound/notfound.component';

import {MatTreeModule} from '@angular/material/tree';



const routes: Routes = [
  { path: '', component: LoginComponent,},
  { path: 'home', component: HomeComponent,canActivate: [AuthGuardGuard]},
  { path: 'facture/:creancier/:creance', component: FactureComponent, canActivate: [AuthGuardGuard]},
  { path: 'password', component: PasswordComponent,canActivate: [AuthGuardGuard]},
  { path: 'recharge', component: RechargeComponent, canActivate: [AuthGuardGuard]},
  { path: 'historique', component: HistoriqueComponent, canActivate: [AuthGuardGuard]},
  { path: 'facture', component: FactureComponent, canActivate: [AuthGuardGuard]},
  { path: 'payementpage', component: PayementpageComponent, canActivate: [AuthGuardGuard]},
  { path: 'rechargepage', component: RechargepageComponent, canActivate: [AuthGuardGuard] },
  { path: 'donation/:data', component: DonationComponent, canActivate: [AuthGuardGuard] },
  { path: '**', component: NotfoundComponent,canActivate: [AuthGuardGuard] },

];
@NgModule({
  declarations: [
    AppComponent,
    LoginComponent,
    HomeComponent,
    FactureComponent,
    NavbarComponent,

    RechargeComponent,
    DonationComponent,
    HistoriqueComponent,
    PayementpageComponent,
    RechargepageComponent,
    PasswordComponent,
    NotfoundComponent,







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
    HttpClientModule,
    FormsModule,
    MatGridListModule,
    MatTreeModule,

  ],
  providers: [],
  bootstrap: [AppComponent]
})
export class AppModule { }
