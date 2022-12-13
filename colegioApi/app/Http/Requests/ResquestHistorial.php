<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class ResquestHistorial extends FormRequest
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
            'descripcion' => 'required|min:9',
            'tipo_evento' => 'required',
            'fecha'   => 'required',
            'hora' =>  'required',
            'rut_alumno'   =>'required',
        ];
    }

    public function messages(){
        return [
            'descripcion.required' => 'Ingreser una descripcion',
            'descripcion.min' => 'La descripcion es muy corta',
            'fecha.required' => 'Ingreser una fecha',
            'hora.required' => 'Ingreser una hora',
            'rut_alumno.required' => 'Ingreser una rut de un alumno',
        ];
    }
}
