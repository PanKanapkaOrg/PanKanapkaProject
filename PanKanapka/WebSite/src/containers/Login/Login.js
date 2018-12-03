import React, { Component } from "react";
import "./Login.css";
import { Redirect } from 'react-router-dom'
import GetLoginData from "../services/api/GetLoginData";

export default class Login extends Component {
  _isMounted = false;

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

      GetLoginData(this.state)
        .then((response) => {
          if (response.status !== 200) {
            console.log(response.text())
            this.setState({ authError: "Błędny login lub hasło" })
          }
          else {
            return response.json()
          }
        })
        .then((login) => {
          if (login != null) {
            this.props.setAppStateProperty("authId", login.authId);
            this.props.setAppStateProperty("cateringFirmId", login.firmId);

            this.props.setAppStateProperty("managerName", login.name);
            this.props.setAppStateProperty("manageSurname", login.surname);
            this.props.setAppStateProperty("cateringFirmName", "Kanapka w pracy");

            this.props.setAppStateProperty("isAuthenticated", true);
          }
        })

    } catch (e) {

      alert(e.message);
    }

  }

  render() {
    const { authError } = this.props;
    if (this.props.isAuthenticated) return <Redirect to='/firm' />
    return (

      <div className="Login">
        <form className="white" onSubmit={this.handleSubmit}>
          <div className="input-field">
            <label >Adress email</label>
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