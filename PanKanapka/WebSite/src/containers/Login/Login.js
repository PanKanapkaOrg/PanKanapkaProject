import React, { Component, Fragment } from "react";
import "./Login.css";
import { Redirect } from 'react-router-dom'

export default class Login extends Component {
  constructor(props) {
    super(props);

    this.state = {
      email: "",
      password: "",
      authError: ""
    };
  }

  validateForm() {
    return this.state.email.length > 0 && this.state.password.length > 0;
  }

  handleChange = event => {
    this.setState({
      [event.target.id]: event.target.value
    });
  }

  handleSubmit = event => {
    event.preventDefault();

    try {
      if (this.state.email == "mateusz@wp.pl" && this.state.password == "12345") {

        this.props.setAppStateProperty("isAuthenticated", true); 
        this.props.setAppStateProperty("authId", 1); 
        this.props.setAppStateProperty("cateringFirmId", 1); 

        this.props.setAppStateProperty("managerName", "Mateusz"); 
        this.props.setAppStateProperty("manageSurname", "Sudak"); 
        this.props.setAppStateProperty("cateringFirmName", "Kanapka w pracy"); 
      }
      else {
        this.state.authError = 'Błędne dane do zalogowania.';
      }
    } catch (e) {

      alert(e.message);
    }
  }

  render() {
    const { authError } = this.props;
    if (this.props.isAuthenticated) return <Redirect to='/' />
    return (

      <div className="Login">
        <form className="white" onSubmit={this.handleSubmit}>
          <div className="input-field">
            <label htmlFor="email">Adress email</label>
            <input type="email" id='email' onChange={this.handleChange} />
          </div>



          <div className="input-field">
            <label htmlFor="password">Hasło</label>
            <input type="password" id='password' onChange={this.handleChange} />
          </div>


          <div className="input-field">
            <button className="btn waves-effect waves-light" disabled={!this.validateForm()} type="submit" onChange={this.handleChange}>Zaloguj</button>
            <div className="center red-text">
              {authError ? <p>{authError}</p> : null}
            </div>
          </div>

          <div className="center red-text">
            {this.state.authError ? <p >{this.state.authError}</p> : null}
          </div>
        </form>
      </div>

    );
  }


}