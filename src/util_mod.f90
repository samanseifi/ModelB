MODULE UTIL
USE VARIABLES
implicit none ;save

CONTAINS

impure elemental real function rand_num()
	call random_number(rand_num)
end function rand_num

!-----------------------------------------------------------------------
!print 2D array signal1 of dimensions Nx by Ny to a file number=file_no
subroutine print_2Dfield(signal1, Nx, Ny, file_no)
	real*8, dimension(0:,0:)   ::signal1
	integer		     ::file_no, Nx,Ny !Nx, Ny -number of gridpoints
	integer		     ::i,j

	! print 2D field              !!!!!!!!!!!
	do i=1, Nx
		do j=1, Ny
			write(file_no,10) signal1(i,j)
			10 FORMAT(E23.16)
		end do
	end do
end subroutine print_2Dfield

!-----------------------------------------------------------------------
!1D analogue of previous routine
subroutine print_1Dfield(signal1, Nx, file_no)
	real*8, dimension(0:)      ::signal1
	integer		     ::file_no, Nx !Nx -number of gridpoints
	integer		     ::i,j

	! print 1D field              !!!!!!!!!!!
	do i=1, Nx
		write(file_no,10) signal1(i)
		10 FORMAT(E23.16)
	end do
end subroutine print_1Dfield

!-----------------------------------------------------------------------
!converts integer "i" to a character string, referenced as "cn(1:il)" in commands
subroutine chari(i,ci,il)
	integer ::i,ii,i3,kk,k,j,j1,il
    real    ::ri
    character(len=9) ci
    character(len=10) str

    ii=i
4   if(ii.gt.999999999) then
		ri=ii
        ii=nint(ri/10)
        goto 4
	end if
    i3=ii
    str='0123456789'
    do 11 k=1,9
		j=10**k
        j1=10**(k-1)
        if((i3.ge.j1).and.(i3.lt.j)) il=k
11  continue
    do 22 k=il,1,-1
   		kk=mod(ii,10)+1
		ci(k:k)=str(kk:kk)
		ii=ii/10
22 	continue
	return
end subroutine chari


!-----------------------------------------------------------------------
!generates guasian distributed deviates with zero mean and unit STD, uses 'ran'
FUNCTION gasdev(idum)
	INTEGER idum
	REAL gasdev
	INTEGER iset
	REAL fac,gset,rsq,v1,v2,ran1
	SAVE iset,gset
	DATA iset/0/

	if (idum.lt.0) iset=0
	if (iset.eq.0) then
1		v1=2.0*ran(idum)-1.0
		v2=2.0*ran(idum)-1.0
		rsq=v1**2+v2**2
	if(rsq.ge.1..or.rsq.eq.0.)goto 1
		fac=sqrt(-2.*log(rsq)/rsq)
		gset=v1*fac
		gasdev=v2*fac
		iset=1
	else
		gasdev=gset
		iset=0
	endif
	return
END FUNCTION gasdev

!-----------------------------------------------------------------------
!gaussian deviates as above, may not work on some compilers
FUNCTION gasdev2()
	INTEGER idum
	REAL gasdev2
	INTEGER iset
	REAL fac,gset,rsq,v1,v2,ran1
	SAVE iset,gset
	DATA iset/0/

	if (idum.lt.0) iset=0
	if (iset.eq.0) then
1  		v1=2.0*rand_num()-1.0
		v2=2.0*rand_num()-1.0
		rsq=v1**2+v2**2
		if(rsq.ge.1..or.rsq.eq.0.)goto 1
			fac=sqrt(-2.*log(rsq)/rsq)
			gset=v1*fac
			gasdev2=v2*fac
			iset=1
		else
			gasdev2=gset
			iset=0
		endif
	return
END FUNCTION gasdev2


End module UTIL
