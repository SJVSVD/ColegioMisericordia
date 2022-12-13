<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class EducadoresRequest extends FormRequest
{
    /**
     * Determine if the user is authorized to make this request.
     *
     * @return bool
     */
    public function authorize()
    {
        return true;
    }

    /**
     * Get the validation rules that apply to the request.
     *
     * @return array<string, mixed>
     */
    public function rules()
    {
        return [
            'rut'=> 'required|unique:educadores,rut',
            'nombre'=> 'required',
            'cod_nivel'=> 'required|numeric',
            'fechaNacimiento'=> 'required',
            'email' => 'required|email|unique:educadores,email',
            'telefono'=> 'required|numeric|min:9|unique:educadores,telefono',
            'sexo' => 'required|min:1',
        ];
    }

    public function messages(){
        return[
            'rut.required'=>'Ingrese un rut valido',
            'rut.unique' => 'El rut ya existe',
            'nombre.required'=>'indique el nombre del educador',
            'email.required' =>'ingrese un email',
            'email.email' => 'El email no tiene un formato correcto',
            'fechaNacimiento.required'=> 'La indique fecha de nacimiento',
            'email.unique' => 'el email ya existe',
            'cod_nivel.required'=>'debe ingresar un nivel',
            'cod_nivel.numeric' => 'El codigo debe ser numerico',
            'telefono.required'=>'ingrese un telefono',
            'telefono.numeric' => 'El telefono solo debe contener numeros',
            'telefono.min' => 'El telefono debe contener 9 digitos',
            'telefono.unique' => 'El telefono ya existe',
            'sexo.required' => 'El sexo es requerido',
            'sexo.min' => 'El sexo solo puede tener un digito',
        ];
    }
}
