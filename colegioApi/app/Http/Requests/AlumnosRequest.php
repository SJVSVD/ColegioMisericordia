<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class AlumnosRequest extends FormRequest
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
            'rut' => 'required|min:9|unique:alumnos,rut',
            'nombre' => 'required',
            'cod_nivel' => 'required|numeric',
            'sexo' => 'required|size:1',
        ];
    }

    public function messages()
    {
        return [
            'rut.required' => 'Indique rut del Alumno',
            'rut.min' => 'El Rut debe tener un minimo de 9',
            'rut.unique' => 'El rut ya existe',
            'nombre.required' => 'Indique nombre del Alumno',
            'cod_nivel.required' => 'Indique nivel del alumno',
            'cod_nivel.numeric' => 'El codigo de nivel debe ser numerico',
            'sexo.required' => 'El sexo es requerido',
            'sexo.min' => 'El sexo solo puede tener un caracter',
        ];
    }


}
