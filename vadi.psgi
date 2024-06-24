#!/usr/bin/perl
use strict;
use warnings;

# Função para validar email
sub verifica_email {
    my $email = shift;
    my $padrao = qr/^[\w\.-]+@[a-zA-Z]+\.[a-zA-Z]{2,}$/;
    return $email =~ $padrao ? 1 : 0;
}

# Função para validar telefone
sub valida_telefone {
    my $numero = shift;
    $numero =~ s/\D//g;

    if (length($numero) == 10 || length($numero) == 11) {
        my $ddd = substr($numero, 0, 2);
        my @ddds_validos = (
            11, 12, 13, 14, 15, 16, 17, 18, 19,
            21, 22, 24, 27, 28, 31, 32, 33, 34, 35, 37, 38,
            41, 42, 43, 44, 45, 46, 47, 48, 49,
            51, 53, 54, 55, 61, 62, 63, 64, 65, 66, 67, 68, 69,
            71, 73, 74, 75, 77, 79,
            81, 82, 83, 84, 85, 86, 87, 88, 89,
            91, 92, 93, 94, 95, 96, 97, 98, 99
        );

        if (grep { $_ == $ddd } @ddds_validos) {
            return 1;
        } else {
            return 0;
        }
    } else {
        return 0;
    }
}

# Função para validar senha
sub verifica_senha {
    my $senha = shift;
    return 0 if length($senha) < 8;
    return 0 unless $senha =~ /[A-Z]/;
    return 0 unless $senha =~ /\d/;
    return 0 unless $senha =~ /[\W_]/;
    return 1;
}

# Função para validar CPF
sub valida_cpf {
    my $cpf = shift;
    $cpf =~ s/\D//g;

    return 0 unless length($cpf) == 11;
    return 0 if $cpf =~ /^(\d)\1{10}$/;

    my $digito_verif1 = 0;
    my $soma = 0;
    for my $i (0..8) {
        $soma += substr($cpf, $i, 1) * (10 - $i);
    }
    my $resto = $soma % 11;
    $digito_verif1 = $resto < 2 ? 0 : 11 - $resto;

    return 0 unless $digito_verif1 == substr($cpf, 9, 1);

    my $digito_verif2 = 0;
    $soma = 0;
    for my $i (0..9) {
        $soma += substr($cpf, $i, 1) * (11 - $i);
    }
    $resto = $soma % 11;
    $digito_verif2 = $resto < 2 ? 0 : 11 - $resto;

    return 0 unless $digito_verif2 == substr($cpf, 10, 1);

    return 1;
}

# Função para validar data
sub valida_data {
    my $data = shift;
    my @formatos = ('%Y-%m-%d', '%d/%m/%Y');
    my $data_valida = 0;

    foreach my $formato (@formatos) {
        eval {
            my $dt = DateTime::Format::Strptime->new(
                pattern => $formato,
                on_error => 'croak',
            )->parse_datetime($data);
            $data_valida = 1;
        };
        last if $data_valida;
    }

    return 0 unless $data_valida;

    eval {
        my ($ano, $mes, $dia) = split(/[-\/]/, $data);
        my $dt = DateTime->new(
            year => $ano,
            month => $mes,
            day => $dia,
        );
    };
    return $@ ? 0 : 1;
}

# Função para validar nome de usuário
sub valida_nome_usuario {
    my $usuario = shift;
    return 0 unless $usuario =~ /^[a-zA-Z0-9_]+$/;
    return 0 unless length($usuario) >= 3 && length($usuario) <= 20;
    return 1;
}
1;
